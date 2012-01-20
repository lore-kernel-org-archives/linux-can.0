From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3 V3.1] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Fri, 20 Jan 2012 13:34:14 +0100
Message-ID: <4F195F46.6080102@grandegger.com>
References: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org> <4F191D44.9080101@hartkopp.net> <4F195E08.5010504@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41526 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab2ATMe0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2012 07:34:26 -0500
In-Reply-To: <4F195E08.5010504@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Alan Stern <stern@rowland.harvard.edu>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Oliver,

On 01/20/2012 01:28 PM, Oliver Hartkopp wrote:

> @Wolfgang: I always get "RTNETLINK answers: Device or resource busy"
> when the device is up - even on the EMS PCMCIA card. Should the manual
> restart generally be also possible even when the device is up??

The restart is only for bus-off recovery. It will *not* restart if you
are not in bus-off.

> I think the automatic restart (with restart-ms) has no preconditions to
> the device up/down state.

But it only triggers in case of bus-off. It has nothing to do with up/down.

Wolfgang.
