From: vklein <vk4514@arcor.de>
Subject: how to check if can0 is up
Date: Mon, 04 May 2015 21:10:06 +0200
Message-ID: <5547C40E.9050107@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:41976 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbbEDTKJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 May 2015 15:10:09 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 3lgYfR0b65z6Gt5
	for <linux-can@vger.kernel.org>; Mon,  4 May 2015 21:10:07 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 02C4F112541
	for <linux-can@vger.kernel.org>; Mon,  4 May 2015 21:10:07 +0200 (CEST)
Received: from [192.168.2.110] (dslb-088-076-134-159.088.076.pools.vodafone-ip.de [88.76.134.159])
	(Authenticated sender: vk4514@arcor.de)
	by mail-in-14.arcor-online.net (Postfix) with ESMTPA id 3lgYfQ6SqCz4nSX
	for <linux-can@vger.kernel.org>; Mon,  4 May 2015 21:10:06 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi
I want to test the status of can0 on a BeagleBoneBlack with serial-can 
cape from Logic Supply.

The interface is initialized with
ip link set can0 type can bitrate 250000
ifconfig can0 up


I have tried
cat /sys/class/net/can0/operstate
but this does not work correctly

if can0 is down,  I get "down"

if can0 is up , I get "unknown"
ifconfig says:
can0      Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           UP RUNNING NOARP  MTU:16  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:10
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
           Interrupt:55


help appreciated

Victor
