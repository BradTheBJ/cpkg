const std = @import("std");
const cpkgInit = @import("cpkgInit.zig");
pub fn handleInput(args: []const []const u8) !void {
    if (args.len < 2) {
        std.debug.print("Not enough arguments\n", .{});
        return;
    }

    if (std.mem.eql(u8, args[1], "init")) {
        try cpkgInit.cpkgInit();
    }
}
