import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:path/path.dart' as p;

void main() async {
  Directory current_dir = Directory.current;
  final app = Alfred(onNotFound: ((req, res) {
    return res.json({"@type": "error", "message": "tidak ada route ini"});
  }));

  app.get('/*', (req, res) => Directory(p.join(current_dir.path, "public")));

  app.all("/", (req, res) {
    res.headers.contentType = ContentType.html;
    return File(
      p.join(current_dir.path, "public", "index.html"),
    );
  });

  app.all("/api", (req, res) {
    return res.json({
      "@type": "ok",
      "result": {"method": req.method, "params": req.params}
    });
  });

  await app.listen();
}
