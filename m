From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: SocketCAN device enumeration API
Date: Tue, 9 Aug 2016 16:04:53 +0200
Message-ID: <20160809140453.GE25116@airbook.newtec.eu>
References: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:34321 "EHLO
	relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcHIOE6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2016 10:04:58 -0400
Content-Disposition: inline
In-Reply-To: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?QW5kcsOp?= Hartmann <aha_1980@gmx.de>
Cc: linux-can@vger.kernel.org


--- Original message ---
> Date:	Tue, 9 Aug 2016 13:06:39 +0200
> From: André Hartmann <aha_1980@gmx.de>
> To: linux-can@vger.kernel.org
> Subject: SocketCAN device enumeration API
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
>  Thunderbird/45.2.0
> 
> Hello all,
> 
> I'm one of the developers working on the new QtSerialBus module [0], [1]
> which encapsulates different CAN hardware drivers (including SocketCAN) in a
> C++ API.
> 
> For a new hardware enumerating function, I'd like to do the following:
> 
> * Enumerate the currently available (i.e. ready to use)
>   SocketCAN devices

I did write myself an enumif() function (abstracted in libenumif)
that you can find on http://github.com/kurt-vd/enumif
You can easily enumerate only CAN interfaces, by hiding non-CAN
interfaces.

> * Get hardware information/manufacturer/bus type for a device
> * Find out if a device is virtual
> * Find out if a device is CAN FD capable

This is IMHO best done using libsocketcan.

Kind regards,
Kurt
