From: Katoch <din.gulu.er@gmail.com>
Subject: Tutorial or Read-me file for Linux can API
Date: Fri, 5 Apr 2013 04:29:09 +0000 (UTC)
Message-ID: <loom.20130405T062502-943@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46423 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab3DEEeo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 5 Apr 2013 00:34:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UNyMi-0007To-Ah
	for linux-can@vger.kernel.org; Fri, 05 Apr 2013 06:35:04 +0200
Received: from ns10.dnsmadeeasy.com ([208.94.148.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 05 Apr 2013 06:35:04 +0200
Received: from din.gulu.er by ns10.dnsmadeeasy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 05 Apr 2013 06:35:04 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I am going through a can base network driver for MCP-2515
https://github.com/raspberrypi/linux/blob/rpi-3.6.y/drivers/net/can/mcp251x.c

Please suggest where i can find the description of the function, :--
alloc_candev
open_candev
alloc_can_skb
can_dropped_invalid_skb
alloc_can_err_skb
etc .....

Is there some read-me file or some tutorial ?

Please suggest.

//Katoch


