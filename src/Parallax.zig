pub const Parallax = @This();

const std = @import("std");
const rl = @import("raylib");

backgrounds: [3]rl.Texture2D,
scrollings: [3]f32 = @splat(0.0),

pub fn init() Parallax {
    var backgrounds: [3]rl.Texture2D = undefined;
    inline for (&backgrounds, 0..) |*background, i| {
        const background_path = std.fmt.comptimePrint("assets/bg{d}.png", .{i + 1});
        background.* = rl.LoadTexture(background_path);
    }
    return .{ .backgrounds = backgrounds };
}

pub fn deinit(self: Parallax) void {
    for (self.backgrounds) |backround| rl.UnloadTexture(backround);
}

pub fn update(self: *Parallax) void {
    for (self.backgrounds, &self.scrollings, 0..3) |background, *scroll, i| {
        scroll.* -= (0.01 + 0.05 * @as(f32, @floatFromInt(i)));
        const width = @as(f32, @floatFromInt(background.width));
        // const heigth = @as(f32, @floatFromInt(background.height));
        if (scroll.* <= -width * 2) scroll.* = 0;
        rl.DrawTextureEx(
            background,
            .{ .x = -scroll.*, .y = 20 },
            0,
            1,
            rl.WHITE,
        );
        rl.DrawTextureEx(
            background,
            .{ .x = -(scroll.* + width), .y = 20 },
            0,
            1,
            rl.WHITE,
        );
    }
}
