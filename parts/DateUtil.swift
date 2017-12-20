import Foundation

class DateUtil {
    
    static func elapsedMinutesToNow(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Int {
        
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))!
        
        let date = Date()
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        let dateTo = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))!
        
        let comps = calendar.dateComponents([.minute], from: dateFrom, to: dateTo)
        
        return comps.minute!
        
    }
    
    static func toDays(day:Int) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"

        
        let calendar = Calendar.current
        let date = Date()
        
        let comps = DateComponents(day: day)
        let dateTo = calendar.date(byAdding: comps, to: date)

        return formatter.string(from: dateTo!)
        
    }
    
}

extension DateUtil {
    
    static func getOffset() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ZZZ"
        let now = Date()
        let locale = Locale(identifier: NSLocale.preferredLanguages.first!)
        _ = now.description(with: locale)
        let dateStr = dateFormatter.string(from: now)
        
        return dateStr
        
    }
    
    static func getStartOf() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' '00:00:00"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func getEndOf() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' '23:59:59"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func genUtcDateTime(target:String, offset:String) -> String {
        
        let calendar = Calendar.current
        let date = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier:"UTC")
        formatter.locale = Locale(identifier:"en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let utc = formatter.string(from: date!)
        return utc
        
    }
    
    static func getDiffHour(target:String) -> Int {
        
        return Int(target[target.index(target.startIndex, offsetBy: 1)..<target.index(target.endIndex, offsetBy: -2)])!
        
    }
    
    static func getDiffMinute(target:String) -> Int {
        
        return Int(target[target.index(target.endIndex, offsetBy: -1)...])!
        
    }
    
    static func getDiffSign(target:String) -> String {
        
        return String(target.prefix(1))
        
    }
    
    static func getYear(target:String) -> Int {
        
        return Int(String(target.prefix(4)))!
        
    }
    
    static func getMonth(target:String) -> Int {
        
        return Int(target[target.index(target.startIndex, offsetBy: 5)..<target.index(target.endIndex, offsetBy: -12)])!
        
    }
    
    static func getDay(target:String) -> Int {
        
        return Int(target[target.index(target.startIndex, offsetBy: 8)..<target.index(target.endIndex, offsetBy: -9)])!
        
    }
    
    static func getHour(target:String) -> Int {
        
        return Int(target[target.index(target.startIndex, offsetBy: 11)..<target.index(target.endIndex, offsetBy: -6)])!
        
    }
    
    static func getMinute(target:String) -> Int {
        
        return Int(target[target.index(target.startIndex, offsetBy: 14)..<target.index(target.endIndex, offsetBy: -3)])!
        
    }
    
    static func getSecond(target:String) -> Int {
        
        return Int(target[target.index(target.endIndex, offsetBy: -1)...])!
        
    }
    
    static func genDateAfterSpecificHour(target:String, specificHour:Int) -> String {
        
        let calendar = Calendar.current
        
        let date = calendar.date(bySettingHour: specificHour, minute: 0, second: 0, of: Date())
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier:"UTC")
        formatter.locale = Locale(identifier:"en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        
        return formatter.string(from: date!)
        
    }
    
    static func genDateStringFromUnix(unix:Int) -> String {
        
        let dateUnix: TimeInterval = TimeInterval(unix)
        let date = NSDate(timeIntervalSince1970: dateUnix)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date as Date)
    }
    
    static func formatToAmPm(unix:Int) -> String {
        
        let dateUnix: TimeInterval = TimeInterval(unix)
        let date = NSDate(timeIntervalSince1970: dateUnix)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: date as Date)
        
    }
    
    static func isAmPm(unix:Int) -> String {
        
        let dateUnix: TimeInterval = TimeInterval(unix)
        let date = NSDate(timeIntervalSince1970: dateUnix)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = Const.timeMemo.am.rawValue
        formatter.pmSymbol = Const.timeMemo.pm.rawValue
        let dateStr = formatter.string(from: date as Date)
        if dateStr.contains(Const.timeMemo.am.rawValue) {
            
            return Const.timeMemo.am.rawValue
            
        } else {
            
            return Const.timeMemo.pm.rawValue
            
        }
    }
    
    static func getNowYear() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func getNowMonth() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func getNowDay() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func getNowDays() -> String {
        
        let now = Date()
        let cal: NSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let comp: NSDateComponents = cal.components(
            [NSCalendar.Unit.weekday],
            from: now
            ) as NSDateComponents
        let weekday: Int = comp.weekday
        let weekdaySymbolIndex: Int = weekday - 1
        let formatter: DateFormatter = DateFormatter()
        
        formatter.locale = Locale(identifier: NSLocale.preferredLanguages.first!)
        
        return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
        
    }
    
    static func getNowHHMM() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func getNowAmPm() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func getNowClockString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let now = Date()
        return formatter.string(from: now)
        
    }
    
    static func castSecondsToClockFormat(value: Int) -> String {
        
        let hours = value / 3600
        let minutes = (value % 3600) / 60
        let seconds = (value % 3600) % 60
        
        let zeroPadHours = String(format: "%01d", hours)
        let zeroPadMinutes = String(format: "%02d", minutes)
        let zeroPadSeconds = String(format: "%02d", seconds)
        
        return zeroPadHours + ":" + zeroPadMinutes + ":" + zeroPadSeconds
        
    }
    
    static func castSecondsToClockFormatOnlyMinutes(value: Int) -> String {
        
        let minutes = value / 60
        let seconds = value % 60
        
        let zeroPadMinutes = String(format: "%02d", minutes)
        let zeroPadSeconds = String(format: "%02d", seconds)
        
        return zeroPadMinutes + ":" + zeroPadSeconds
        
    }
    
    static func isPassedNowUnixtime(target:Int) -> Bool {
        
        let date:NSDate = NSDate()
        let now = Int(date.timeIntervalSince1970)
        
        return now > target
        
    }
    
    static func getHHMM(date: Date?) -> String {
        
        guard let target = date else {
            
            return ""
            
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: target)
        
    }
    
    static func getAmPm(date: Date?) -> String {
        
        guard let target = date else {
            
            return ""
            
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: target)
        
    }
    
    static func getClockString(date: Date?) -> String {
        
        guard let target = date else {
            
            return ""
            
        }
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: target)
        
    }
    
    static func calcTimeToTime(from: Date?, to: Date?) -> Double {
        
        guard let f = from, let t = to else {
            
            return 0.0
            
        }
        
        return t.timeIntervalSince(f)
        
    }
    
}

