const std = @import("std");
const rl = @import("raylib");

const Parallax = @import("Parallax.zig");

///100px = 1 meter
pub const height: u32 = 900;
pub const width: u32 = 1500;

pub fn main() !void {
    rl.SetTraceLogLevel(rl.LOG_WARNING);
    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE | rl.FLAG_MSAA_4X_HINT);
    rl.InitWindow(width, height, "Zenon");
    defer rl.CloseWindow();

    const camera: rl.Camera2D = .{ .zoom = 1.0, .offset = .{ .x = 0.0, .y = 100.0 * 8.5 } };
    const parallax: Parallax = undefined;
    _ = parallax;

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        rl.ClearBackground(rl.PINK);
        rl.BeginMode2D(camera);
        rl.DrawRectangle(0.0, 0.0, 1200.0, 50.0, rl.LIME);
        rl.EndMode2D();
        rl.EndDrawing();
    }
}
