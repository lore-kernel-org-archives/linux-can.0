From: "Harrington, Sean M." <harrington.234@buckeyemail.osu.edu>
Subject: RE: C-Can or Other SocketCAN Issue
Date: Mon, 3 Mar 2014 17:31:16 +0000
Message-ID: <914f07d33a6c473ba415edb4bd05f7b5@BN1PR01MB071.prod.exchangelabs.com>
References: <d634b30117cf40dfb954c723bef01b65@BN1PR01MB071.prod.exchangelabs.com>,<5314AF7F.3010701@pengutronix.de>,<4179fe0897d74eccba72d6c9ba63694c@BN1PR01MB071.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:42331
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751521AbaCCRbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Mar 2014 12:31:20 -0500
In-Reply-To: <4179fe0897d74eccba72d6c9ba63694c@BN1PR01MB071.prod.exchangelabs.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

>> The Beaglebone Black should be running Ubuntu 13.04. I'm willing to
>> rebuild the kernel and install the latest distribution if I can some
>> feedback on the proper method to get SocketCAN functional and if it
>> would most likely resolve the issue.

>Which Kernel version are you using?

Here is what uname -a returned:
Linux arm 3.8.13-bone35 #2 SMP Sat Jan 4 10:18:07 PST 2014 armv7l armv7l armv7l GNU/Linux

cat /proc/version returned:
Linux version 3.8.13-bone35 (root@ubuntu) (gcc version 4.7.3 20130328 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04) ) #2 SMP Sat Jan 4 10:18:07 PST 2014

Sean

      