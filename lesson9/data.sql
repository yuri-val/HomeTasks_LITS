INSERT INTO
  `figures` (`name`)
VALUES
  ('Circle'),
  ('Rectangle'),
  ('Triangle');

INSERT INTO
  `formulas` (`figure_id`, `name`, `formula`)
VALUES
  (1, 'CircleS', "PI * p1 * p1"),
  (2, 'RectangleS', "p1 * p2"),
  (3, 'TriangleS', 'sqrt(((p1+p2+p3)/2)(((p1+p2+p3)/2)-p1)(((p1+p2+p3)/2)-p2)(((p1+p2+p3)/2)-p3))');

INSERT INTO
   `parameter_sets` (`formula_id`, `p1`, `p2`, `p3`, `p4`, `p5`)
VALUES
  (1, 5, NULL, NULL, NULL, NULL),
  (2, 8, 6,    NULL, NULL, NULL),
  (3, 3, NULL, NULL, NULL, NULL),
  (2, 5, NULL, NULL, NULL, NULL),
  (3, 4, 5,    5,    NULL, NULL);

INSERT INTO
   `squares` (`figure_id`, `formula_id`, `parameter_set_id`, `square`)
 VALUES
   (1, 1, 1, 78.53981633974),
   (2, 2, 2, 48.00000000000),
   (3, 3, 3, -1.00000000000),
   (2, 2, 4, -1.00000000000),
   (3, 3, 5, 9.16515138991);

INSERT INTO
   `errors`  (`figure_id`, `formula_id`, `parameter_set_id`, `err_code`, `err_msg`)
VALUES
  (3, 3, 3, 1, "Need more parameters"),
  (2, 2, 4, 1, "Need more parameters");
