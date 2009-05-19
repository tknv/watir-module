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
#�f�t�H���g�ł́A11���߂���ƃ^�C���A�E�g���܂��B
#1�b���ƂɃ����_�����O���ꂽ���ǂ����m�F���܂��B
#�ʏ��watir�ł�wait�͔񓯊��̃����_�����O�֗^���Ȃ����߁B
#������������ł͂Ȃ��ł��B�߂�ǂ��������͊y���܂��傤�B 
#
#==Usage:�g����
#test.rb��reuire 'lib/watir_ajax_lib'
#
#==watir_wait_ajax
#Wating until show that string.
#Because usually watir never wait ajax rendering.
#
#ajax�̃����_�����O��҂̂ł͂Ȃ��A���̕����񂪕\�������܂ő҂B
#�ʏ��watir�ł�wait�͔񓯊��̃����_�����O�֗^���Ȃ����߂���ő҂B
#
#==watir_testn_logging
#Assert that string,if exist OK,no NG and stop testing.
#and logging result.
#
#���̕����񂪂����OK,�Ȃ����NG�Ńe�X�g���~
#�܂��A�e�X�g���ʂ����O�ɋL�^���܂��B
#
#==watir_waitn_test
#Just add wating sequence to above method.
#
#���̕����񂪂��邩�ǂ�����莞�ԑ҂��A�����OK,�Ȃ����NG�Ńe�X�g���~
#�܂��A�e�X�g���ʂ����O�ɋL�^���܂��B
#
#==watir_waitn_clicklink
#If find the link,to click.Otherwise wait until timeout. 
#when timeout,logging and stop testing.
#
#���̃N���b�N�����������񂪕\�������܂ň�莞�ԑ҂��A����΃����N���N���b�N�A�Ȃ����NG�Ńe�X�g���~
#�܂��A�e�X�g���ʂ����O�ɋL�^���܂��B
#
#==execute_script
#invoke java script.
#Not work well yet,one view one invoke limitation now.
#
#javascript�����s����B
#�܂��A���������������߁Aexception error�𖳗����n���h�����O���ē����Ă����
#���͂Ȃ����A�v�����A��J�ڂɕt����javascript invoke�Ȃ���Ȃ��B

#
#==�C������:History
#* 2009.5.18 update
#* 2009.4.27 initial create

require 'rubygems'
require 'watir'
require 'win32ole'
require 'logger'

module Watir
  class IE
#* ajaxtext:: �҂�����Awating string.
#* wtvalue:: �҂�����(�b�P��),wating time sec.
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
#* testname:: ���O�ɕ\�������e�X�g�P�[�X��,testcase name for logging.
#* assrttext:: �A�T�[�V�������镶����,assertion string.
    def watir_testn_logging(testname,assrttext)
        #log
        logger = Logger.new($logfile,3) # per 1 mgb. 3 rotate.
        logger.level = Logger::DEBUG
        if text.include?(assrttext) == true then logger.debug(Time.now.to_s + " #{testname} #{assrttext} OK")
        else logger.debug(Time.now.to_s + " #{testname} #{assrttext} NG");raise "error #{testname} #{assrttext}"
        end
    end
#* testname:: ���O�ɕ\�������e�X�g�P�[�X��,testcase name for logging.
#* assrttext:: �A�T�[�V�������镶����,assertion string.
#* wtvalue:: �҂�����(�b�P��),wating time sec.
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
#* linktext:: �����N��,link text
#* wtvalue:: �҂�����(�b�P��),wating time sec.
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
#* scriptCode:: ���s������javascript,for invoking javascript.
    def execute_script(scriptCode)
            window.execScript(scriptCode)
        end
        def window
            Document.parentWindow
        end
      
  end
end