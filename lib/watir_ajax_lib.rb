#! ruby -Ku
#!/usr/bin/env ruby

require 'rubygems'
require 'watir'
require 'win32ole'
require 'logger'
require 'jcode'

$KCODE = 'UTF8'


module Watir
  class IE
    def watir_wait_ajax(ajaxtext,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
       #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if text.include?(ajaxtext) == true then break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        result_mail
        raise "render too long,stop testing"
        else end
      end
    end
    
    def watir_wait_ajax_links(linksnum,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
       #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if .links.length >= linksnum then break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        result_mail
        raise "render too long,stop testing"
        else end
      end
    end
    
    def watir_wait_ajax_buttons(buttonsnum,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
       #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if .links.length >= buttonsnum then break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        result_mail
        raise "render too long,stop testing"
        else end
      end
    end
    
    def watir_wait_ajax_images(imagesnum,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
       #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if .links.length >= imagesnum then break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        result_mail
        raise "render too long,stop testing"
        else end
      end
    end
    
    def watir_test(testname,assrttext)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
        if text.include?(assrttext) == true then logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK")
        else logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG")
        result_mail
        raise "error #{testname} #{assrttext}"
        end
    end
    
    def watir_waitn_test(testname,assrttext,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if text.include?(assrttext) == true then logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK");break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG")
        result_mail
        raise "render too long ! stop testing."
        else end
      end
    end
    
    def watir_waitn_test_no_exist(testname,assrttext,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if text.include?(assrttext) == true then sleep(1)
        else logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK");break end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG")
        result_mail
        raise "render too long ! stop testing."
        else end
      end
    end
    
    def watir_waitn_clicklink(linktext,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if text.include?(linktext) == true then break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        logger.debug(Time.now.to_s + " Wating #{linktext} NG")
        result_mail
        raise "render too long ! stop testing."
        else end
      end
      link(:text, linktext).click
    end
    
    def execute_script(scriptCode)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
            window.execScript(scriptCode)
        end
        def window
          WIN32OLE.codepage = WIN32OLE::CP_UTF8
            ie.Document.parentWindow
        end
     
      def watir_waitn_test_at_field(testname,assrttext,fieldnumber,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
        wtvalue.times do
          if text_fields[fieldnumber].to_s =~ /#{assrttext}/ then logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK");break
          else sleep(1) end
          if Time.now - srendTime >= wtvalue then
          logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
          logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG")
          raise "render too long ! stop testing."
          else end
        end
      end
     
     def watir_waitn_text_at_field(text,fieldnumber,wtvalue=660)
      WIN32OLE.codepage = WIN32OLE::CP_UTF8
      srendTime = Time.now
        wtvalue.times do
          if text_fields[fieldnumber].to_s =~ /#{text}/ then break
          else sleep(1) end
          if Time.now - srendTime >= wtvalue then
          logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
          logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG")
          result_mail
          raise "render too long ! stop testing."
          else end
        end
      end
     
  end
end
