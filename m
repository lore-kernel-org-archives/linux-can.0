From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: termination?
Date: Wed, 2 Nov 2016 20:41:33 +0100
Message-ID: <20161102194133.GA11171@airbook.vandijck-laurijssen.be>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:40274 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbcKBTlp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 15:41:45 -0400
Content-Disposition: inline
In-Reply-To: <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?utf-8?B?S2/FgsWCxIV0YWos?= Remigiusz <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

> Hi Remik,
> 
> On 10/21/2016 08:47 PM, Kołłątaj, Remigiusz wrote:
> >>I was just looking through your code and wondered whether we should support
> >>the termination switching feature via 'ip' tool or via sysfs.
> >>
> >>Just added Marc in CC.
> >>
> >
> >I tried to use 'ip' for setting up termination, but I couldn't find a
> >way. If this is possible I will modify the driver as it seems to be
> >better idea. Could you give me some hints?
> 
> No - not now :-)
> 
> That's why I wanted to start the discussion whether we should add this kind
> of feature to 'ip'.

selectable 120Ohm termination sounds very familiar, I'm sure I encountered >1
devices in the past offering this, so it's a good thing to discuss.

Looking to the (dis)advantages of both methods, I'd vote for extending
the netlink interface.
Keeping the sysfs interface semantically equal between drivers is hard,
not speaking on the kernel internal issues.

Kurt
