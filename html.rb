require_relative 'average'

print <<EOS
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>放送大学　単位認定試験　平均点</title>
    <link rel="stylesheet" href="average.css">
  </head>
  <body>
    <table>
      <thead>
        <tr><th>区分1</th><th>区分2</th><th>コース</th><th>科目名</th><th>2019年度2学期</th><th>2019年度1学期</th></tr>
      </thead>
      <tbody>
EOS

averages = AVERAGES.sort_by do |x|
  /2019年度2学期（(?<ave2>[0-9.]+)点）/ =~ x[1]
  /2019年度1学期（(?<ave1>[0-9.]+)点）/ =~ x[2]
  [x[5], x[4], x[3], ave2.to_f * -1, ave1.to_f * -1, x[0]]
end

averages.each do |average|
  ave2 = ave1 = nil
  /2019年度2学期（(?<ave2>[0-9.]+)点）/ =~ average[1]
  /2019年度1学期（(?<ave1>[0-9.]+)点）/ =~ average[2]
  if !ave2.nil? && !ave2.empty?
    difficulty2 = ave2.to_f >= 90 ? ' class="very_easy"' : (ave2.to_f < 60 ? ' class="hard"' : '')
  end
  if !ave1.nil? && !ave1.empty?
    difficulty1 = ave1.to_f >= 90 ? ' class="very_easy"' : (ave1.to_f < 60 ? ' class="hard"' : '')
  end
  print <<-EOS
        <tr><td>#{average[3]}</td><td>#{average[4]}</td><td>#{average[5]}</td><td>#{average[0]}</td><td#{difficulty2}>#{ave2}</td><td#{difficulty1}>#{ave1}</td></tr>
  EOS
end

print <<EOS
      </tbody>
    </table>
  </body>
</html>
EOS
