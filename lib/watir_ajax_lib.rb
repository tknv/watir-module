#!/usr/bin/env ruby
#= watir-module
#Authors::   tknv
#Version::   0.2 2009-05-18
#Copyright:: Copyright (C) 2009 tknv. All rights reserved.
#License::   Released under the MIT License: www.opensource.org/licenses/mit-license.php
#
#
#
#
#==very about watir-module & aim
#In default time out more than 11min.this is can change in wtvalue.
#Check rendering per 1sec.
#Because usually watir never wait ajax rendering.
#It is not so good idea,just for anyone DRI.
#
#デフォルトでは、11分過ぎるとタイムアウトします。
#1秒ごとにレンダリングされたかどうか確認します。
#通常のwatirでのwaitは非同期のレンダリング関与しないため。
#たいしたもんではないです。めんどくさい事は楽しましょう。 
#
#==Usage:使い方
#test.rbでreuire 'lib/watir_ajax_lib'
#
#==watir_wait_ajax
#Wating until show that string.
#Because usually watir never wait ajax rendering.
#
#ajaxのレンダリングを待つのではなく、その文字列が表示されるまで待つ。
#通常のwatirでのwaitは非同期のレンダリング関与しないためこれで待つ。
#
#==watir_testn_logging
#Assert that string,if exist OK,no NG and stop testing.
#and logging result.
#
#その文字列があればOK,なければNGでテストを停止
#また、テスト結果をログに記録します。
#
#==watir_waitn_test
#Just add wating sequence to above method.
#
#その文字列があるかどうを一定時間待ち、あれはOK,なければNGでテストを停止
#また、テスト結果をログに記録します。
#
#==watir_waitn_clicklink
#If find the link,to click.Otherwise wait until timeout. 
#when timeout,logging and stop testing.
#
#そのクリックしたい文字列が表示されるまで一定時間待ち、あればリンクをクリック、なければNGでテストを停止
#また、テスト結果をログに記録します。
#
#==execute_script
#invoke java script.
#Not work well yet,one view one invoke limitation now.
#
#javascriptを実行する。
#また、動きが怪しいため、exception errorを無理やりハンドリングして動いている状況
#問題はないが、要検討、一遷移に付き一javascript invokeなら問題ない。

#
#==修正履歴:History
#* 2009.5.18 update
#* 2009.4.27 initial create

require 'rubygems'
require 'watir'
require 'win32ole'
require 'logger'

module Watir
  class IE
#* ajaxtext:: 待つ文字列、wating string.
#* wtvalue:: 待ち時間(秒単位),wating time sec.
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
#* testname:: ログに表示されるテストケース名,testcase name for logging.
#* assrttext:: アサーションする文字列,assertion string.
    def watir_testn_logging(testname,assrttext)
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
        if text.include?(assrttext) == true then logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK")
        else logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG");raise "error #{testname} #{assrttext}"
        end
    end
#* testname:: ログに表示されるテストケース名,testcase name for logging.
#* assrttext:: アサーションする文字列,assertion string.
#* wtvalue:: 待ち時間(秒単位),wating time sec.
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
#* linktext:: リンク名,link text
#* wtvalue:: 待ち時間(秒単位),wating time sec.
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
#* scriptCode:: 実行したいjavascript,for invoking javascript.
    def execute_script(scriptCode)
            window.execScript(scriptCode)
        end
        def window
            Document.parentWindow
        end
      
  end
end