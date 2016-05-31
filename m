From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Rx not working when not started from terminal
Date: Tue, 31 May 2016 12:04:01 +0200
Message-ID: <20160531100401.GB27305@airbook>
References: <e0cee7e7-07c8-feac-7262-d62c020d07f7@laure.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:37377 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcEaKPV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 May 2016 06:15:21 -0400
Content-Disposition: inline
In-Reply-To: <e0cee7e7-07c8-feac-7262-d62c020d07f7@laure.nz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@laure.nz
Cc: linux-can@vger.kernel.org

Hi,

> Hi,
> 
> I can only send but not receive can messages with an Ixxat USB-to-CAN V2 and
> a Lawicel CANUSB over can0 (via Ixxat's ixx_usb) and slcan0 (via an
> udev-triggered slcand) respectively. When I start slcand from a terminal,
> slcan0 works as expected. Do you have an idea what could be the problem?

So, to summarize: slcand does not work when started from udev,
and slcand does work when started in an interactive terminal.

I believe the terminal is not making the difference here.
I do know that sometimes one can have race conditions
with udev rules since not all attributes are present on the launch
of the uevent. can you insert a "sleep 1" in front of the slcand launch
script?

Kurt
