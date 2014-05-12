From: Jeff Holtz <jeff.holtz@movimentogroup.com>
Subject: Rebuild Drivers for Ubuntu
Date: Mon, 12 May 2014 05:13:25 +0000 (UTC)
Message-ID: <loom.20140512T070934-65@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40302 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaELFPF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 May 2014 01:15:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WjiZq-000425-U0
	for linux-can@vger.kernel.org; Mon, 12 May 2014 07:15:03 +0200
Received: from c-69-246-11-150.hsd1.mi.comcast.net ([69.246.11.150])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 May 2014 07:15:02 +0200
Received: from jeff.holtz by c-69-246-11-150.hsd1.mi.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 May 2014 07:15:02 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm developing some ISOTP programs and would like to rebuild the drivers to
include the CAN-ISOTP.ko file for UBUNTU (currently using 14.04 LTS)  I can
get the code for the build for 14.04 which includes all the can, can-bcm,
can-raw ko's but nt the isotp.  I've git the can-modules but having
difficulties merging the latest code and where to place it to build.  Any
help/instructions would be appreciated.

for example:
   cp ~/can-modules /usr/src/linux-3-13.0/.
   make SUBDIR=drivers/net/can

