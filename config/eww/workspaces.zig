const std = @import("std");

const Entry = struct {
    type: []const u8,
    on_click: []const u8,
    classes: []const u8,
    icon: []const u8
};

const ws_names = std.ComptimeStringMap(usize, .{
    .{ "I", 0 }, .{ "II", 1 }, .{ "III", 2 }, .{ "IV", 3 }, .{ "V", 4 },
    .{ "VI", 5 }, .{ "VII", 6 }, .{ "VIII", 7 }, .{ "IX", 8 }, .{ "X", 9 }
});
const focused_icon = "";
const focused_classes = "offset-icon focused-ws";
const occupied_icon = "";
const occupied_classes = "offset-icon occupied-ws";
const empty_icon = "";
const empty_classes = "offset-icon";

pub fn main() !void {
    var args_iter = std.process.args();
    _ = args_iter.next();
    const dname = if(args_iter.next()) |dname| dname else return error.NoDesktopName;

    var alloc = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer alloc.deinit();

    var workspaces: [10]Entry = undefined;
    for(ws_names.kvs) |kvs| {
        workspaces[kvs.value] = Entry{
            .type = "e", .classes = empty_classes, .icon = empty_icon,
            .on_click = try std.fmt.allocPrint(alloc.allocator(), "bspc desktop -f {s}.local", .{ kvs.key })
        };
    }

    const ws_occupied_result = try std.ChildProcess.exec(.{
        .allocator = alloc.allocator(),
        .argv = &.{ "bspc", "query", "-D", "-d", ".occupied.local", "-m", dname, "--names" }
    });
    var ocu_iter = std.mem.tokenize(u8, ws_occupied_result.stdout, " \n");
    while(ocu_iter.next()) |ws| {
        workspaces[ws_names.get(ws).?].type = "o";
        workspaces[ws_names.get(ws).?].classes = occupied_classes;
        workspaces[ws_names.get(ws).?].icon = occupied_icon;
    }

    const ws_focused_result = try std.ChildProcess.exec(.{
        .allocator = alloc.allocator(),
        .argv = &.{ "bspc", "query", "-D", "-d", ".focused.local", "-m", dname, "--names" }
    });
    var foc_iter = std.mem.tokenize(u8, ws_focused_result.stdout, " \n");
    while(foc_iter.next()) |ws| {
        workspaces[ws_names.get(ws).?].type = "f";
        workspaces[ws_names.get(ws).?].classes = focused_classes;
        workspaces[ws_names.get(ws).?].icon = focused_icon;
    }

    var out = std.ArrayList(u8).init(alloc.allocator());
    _ = try std.json.stringify(workspaces, .{}, out.writer());
    try std.io.getStdOut().writer().print("{s}\n", .{ out.items });
}