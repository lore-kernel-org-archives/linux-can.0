From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Fri, 8 Mar 2013 14:07:33 +0100
Message-ID: <20130308130733.GA1332@vandijck-laurijssen.be>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
 <20130307124012.GC603@vandijck-laurijssen.be>
 <5139A78D.9060005@pengutronix.de>
 <20130308100548.GA496@vandijck-laurijssen.be>
 <5139D3D8.2020305@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from Mailrelay020.isp.belgacom.be ([195.238.6.95]:57093 "EHLO
	mailrelay020.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932120Ab3CHNHk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 08:07:40 -0500
Content-Disposition: inline
In-Reply-To: <5139D3D8.2020305@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Mar 08, 2013 at 01:04:40PM +0100, Oliver Hartkopp wrote:
> Am 08.03.2013 11:05, schrieb Kurt Van Dijck:
> 
> >>>The J1939 API that is available on gitorious[1] is waiting for acceptance.
> >>>The API has not changed for almost a year now, and is working.
> >>>The J1939 API is quite different from raw CAN, since J1939 adds an
> >>>addressing scheme. This makes it hard for non-J1939 users to
> >>>judge about the usefullness of the API.
> 
> Yes. Unfortunately.
> 
> >>>Therefore, it's important that users of the J1939 stack share their
> >>>opinion about it.
> >>>Therefore, also your opinion matters and may contribute to the acceptance.
> >>>If you find the J1939 stack usefull of course :-)
> 
> Indeed user feedback is really required.
> 
> >>
> >>Would it be possible to add the j1939 support to staging? I mean from
> >>the technical and from the political (is staging reserved for drivers
> >>only?) point of view.
> >
> >That is a good idea.
> >Technically, staging is underneath drivers/, which answers the political
> >question: yes, it's for drivers probably.
> 
> Please check:
> 
> http://www.kroah.com/log/linux/linux-staging-update.html
> 
> It's for "drivers" and "filesystems".
> 
> You don't need to modify the kernel infrastructure to add drivers and
> filesystems - but you need to change infrastructure to add new networking
> functionalities.
> 
> Therefore i don't think, that this would work with the staging approach.
> 
> Btw. how can we gain more interest and users to the evaluation of Kurts j1939
> stack? I remember about 3 persons asking about it (even about details) - what
> happened to them?

So how about
http://lxr.linux.no/linux+v3.8.2/init/Kconfig#L35 ?
I get the impression that if we let J1939 depend on EXPERIMENTAL, then
we are close to a stack that:
* get attention easily.
* is easy to evaluate due to the mainline inclusion.

Kind regards,
Kurt
