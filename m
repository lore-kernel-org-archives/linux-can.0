From: "Ruan TingQuan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
Subject: Does PEAK usb can support getting error count?
Date: Thu, 15 Jan 2015 02:21:02 +0000
Message-ID: <4eb3ad60f4ab4f6d9fd71dc4231a1811@SGPMBX1006.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:33941 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbAOC0s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 21:26:48 -0500
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 4984EC0822
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2015 03:21:08 +0100 (CET)
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 682E61580015
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2015 03:21:06 +0100 (CET)
Received: from SI-MBX1017.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 541F02380473
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2015 03:21:06 +0100 (CET)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Linux-can-team,

I am using PEAK-USB-CAN adapter in my linux system (kernel 3.11). 
When I try to get RX/TX error count via netlink interface, return nothing. But it work fine on getting state, bittiming, control mode.

Does PEAK usb can support error count getting? If not, is there plan to have it?

Regards!
Leo Ruan
