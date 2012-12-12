From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Wed, 12 Dec 2012 14:35:47 +0100
Message-ID: <3357578.4okCBEnLQl@ws-stein>
References: <loom.20121114T160521-534@post.gmane.org> <50C1160A.20203@grandegger.com> <loom.20121211T153556-802@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:45314 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041Ab2LLNfw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Dec 2012 08:35:52 -0500
In-Reply-To: <loom.20121211T153556-802@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Michael,

On Tuesday 11 December 2012 14:46:37, Michael Pellegrini wrote:
> I applied the patch provided.  On driver load, dmesg reports the following:
> 
> [  379.817717] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
> got: 0x2000
> [...]

This should be expected due to the reserved bit set as 1. But I get the same behavior if there is no i2c traffic: CAN works fine. I'm just losing some messages at some time which is IMO related to the algorithm.

> Based on a quick test, the CAN interface appears functional with this driver.
> However, I am unable to test the I2C interface as I can't get I2C devices to
> appear in /dev right now.

An /dev/i2c-0 (or -1 or whatever, depending on your bus number ordering) should be enough to use things as i2cdetect. On the other hand if you have hwmon sensors they can be queried from within /sys/class/hwmon/hwmonX/

Best regards,
Alexander

