const std = @import("std");
const rl = @import("raylib");

pub fn main() !void {
    rl.SetTraceLogLevel(rl.LOG_WARNING);
    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE | rl.FLAG_MSAA_4X_HINT);
    rl.InitWindow(1500, 900, "Zenon");
    defer rl.CloseWindow();

    const camera: rl.Camera2D = .{ .zoom = 1.0, .offset = .{ .x = 0.0, .y = 100.0 * 8.5 } };

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        rl.ClearBackground(rl.PINK);
        rl.BeginMode2D(camera);
        rl.DrawRectangle(0.0, 0.0, 1200.0, 50.0, rl.LIME);
        rl.EndMode2D();
        rl.EndDrawing();
    }
}
