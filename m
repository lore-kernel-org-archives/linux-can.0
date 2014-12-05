From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: CAN presume-ack feature
Date: Fri,  5 Dec 2014 10:59:49 +0300
Message-ID: <1417766390-4587-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:48995 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaLEIA1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Dec 2014 03:00:27 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-netdev@vger.kernel.org

Hello, all.

I just remembered about this small patch I promised to submit.
It corresponds to an earlier introduced change in SocketCAN subsystem, see
http://thread.gmane.org/gmane.linux.can/6110
