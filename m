From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/5] can: Kconfig: switch on CAN_RAW by default
Date: Mon, 03 Dec 2012 18:43:09 +0100
Message-ID: <50BCE4AD.5010301@hartkopp.net>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de> <1354197491-31205-4-git-send-email-mkl@pengutronix.de> <50B85681.8030502@hartkopp.net> <50B86BF9.6020202@pengutronix.de> <50B8E6AA.4090209@hartkopp.net> <50BCAB7D.5070604@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:59154 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab2LCRnO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 12:43:14 -0500
In-Reply-To: <50BCAB7D.5070604@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 03.12.2012 14:39, Marc Kleine-Budde wrote:

> On 11/30/2012 06:02 PM, Oliver Hartkopp wrote:


>> IMO all entries (RAW/BCM/GW) should be enabled by default when CAN is
>> selected. When people really know what they do, the might deselect entries at
>> their own risc ...
> 
> YMMV, BCM and GW are for experienced can users. But I can change the
> patch to enable RAW, BCM and GW on by default.


That would be ok!

The problem is, when an application from an experienced CAN developer hits a
Linux-box from an inexperienced user.

Trying to help this user to compile / install the missing protocols is a mess.
So having all 'enabled' by default once CAN is selected is much better.

Tnx,
Oliver
