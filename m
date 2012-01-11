From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: Possible bug in ac_msg_is_request_for_ac
Date: Wed, 11 Jan 2012 11:01:50 +0100
Message-ID: <CAJsOQGPhXvDvnoY3MP6zEVOnYD0_BHjhg7UhAb=vSkVrVGNcow@mail.gmail.com>
References: <1326198848.2189.9.camel@osblap120.dev.osb-ag.de>
	<20120110150158.GB2524@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39740 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab2AKKBv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 05:01:51 -0500
Received: by werm1 with SMTP id m1so371709wer.19
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2012 02:01:50 -0800 (PST)
In-Reply-To: <20120110150158.GB2524@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, kurt.van.dijck@eia.be

Hi,

On Tue, Jan 10, 2012 at 4:01 PM, Kurt Van Dijck <kurt.van.dijck@eia.be> wrote:
> By a second look, this function is only used to decide if a request
> from source address 0xfe may be sent out.
> I'm sure my intent is conform to the specification, but I'm
> not sure anymore taht I should enforce such policy inside the kernel.

Yep, AFAIK this matches the J1939 and ISOBUS specification.

> I may as well delete the function completely ...

Maybe also a good solution, cause all the SA stuff is very simple and
obvious. Everyone developing with SocketCAN J1939 should know about.

cheers,

Felix
