From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Thu, 12 Jul 2012 00:22:40 +0200
Message-ID: <4FFDFCB0.60109@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <201207091519.04235.pisa@cmp.felk.cvut.cz> <20120709144042.GA2671@vandijck-laurijssen.be> <23562188.349Ls0e8RT@ws-stein> <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com> <4FFB43FF.8060305@grandegger.com> <CABMxt4iM=nKdZVwvq-13ByBYUyJv_s07fWBgYe3MdfTSRg-OaA@mail.gmail.com> <CABMxt4i1JN9HG-0AU60gOt-kBRir=qu2zMvhpCPsBv8xRTWn1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39206 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030328Ab2GKWWo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jul 2012 18:22:44 -0400
In-Reply-To: <CABMxt4i1JN9HG-0AU60gOt-kBRir=qu2zMvhpCPsBv8xRTWn1A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Linux-CAN <linux-can@vger.kernel.org>

On 07/11/2012 02:35 PM, Mohamed HAMZAOUI wrote:
> Hi,
> 
> I run the test and actually i have around 1ms (my specified period) ,

Sounds better.

> the jitter is up to 24 microseonds. it's better than using only
> clock_nannosleep.

With or without load?

> I think my preblem is solved but can I minimize the gitter and why
> when i use only clock_nannosleep i have the 300 us ?

The jitter above is far to good for Linux without preempt-rt. Try with
more load and a longer run time.

Wolfgang.
