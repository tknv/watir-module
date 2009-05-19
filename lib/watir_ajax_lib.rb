#!/usr/bin/env ruby
require 'rubygems'
require 'watir'
require 'win32ole'
require 'logger'

module Watir
  class IE
    def watir_wait_ajax(ajaxtext,wtvalue=660)
       #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
      srendTime = Time.now
      wtvalue.times do
        if text.include?(ajaxtext) == true then break
        else sleep(1) end
        if Time.now - srendTime >= wtvalue then
        logger.debug(Time.now.to_s + " Time out ! this is too long rendering,more than #{wtvalue}sec.")
        raise "render too long,stop testing"
        else end
      end
    end
    def watir_testn_logging(testname,assrttext)
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
        if text.include?(assrttext) == true then logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK")
        else logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG");raise "error #{testname} #{assrttext}"
        end
    end
    def watir_waitn_test(testname,assrttext,wtvalue=660)
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
        raise "render too long ! stop testing."
        else end
      end
    end
    def watir_waitn_clicklink(linktext,wtvalue=660)
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
        raise "render too long ! stop testing."
        else end
      end
      link(:text, linktext).click
    end
    def execute_script(scriptCode)
            window.execScript(scriptCode)
        end
        def window
            Document.parentWindow
        end
      
  end
end