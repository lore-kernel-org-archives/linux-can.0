From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 2 Apr 2015 11:23:40 -0700
Message-ID: <CAE+ymruub9WORX+GWtAOVgTHvUzL3L8fFabr2nQqU9uCVr=2dg@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
	<5519E5A9.7080104@optusnet.com.au>
	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
	<551A0FF3.4070400@optusnet.com.au>
	<CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
	<551C7D79.50906@optusnet.com.au>
	<loom.20150402T022922-646@post.gmane.org>
	<551CA777.8070208@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35591 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbbDBSXl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 14:23:41 -0400
Received: by obbfy7 with SMTP id fy7so56708281obb.2
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2015 11:23:40 -0700 (PDT)
In-Reply-To: <551CA777.8070208@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

Dan, thank you for sharing similar concerns on this thread.

Tom, I appreciate the detailed conversation about this topic -- even
if there is no facility to address the underlying priority concerns
fully in Linux (yet?), it's a nice public service that we are exposing
the relevant caveats regarding priority management to the general
SocketCAN user base.  Your initial points about system architecture
and design are certainly understood, although not foreign to those of
us who are reasonably experienced with CAN already.

> Generic and simple versus custom and complicated. Give me simple any day.

Indeed, the current scheme probably satisfies 95% of the users of
SocketCAN.  At the same time, if SocketCAN is supposed to be the one
CAN interface to rule all CAN interfaces on Linux, it's worth thinking
about "power-user" features that provide functionality that is fully
in keeping with the CAN specification.

> And everything else in Linux is "perfect"?

True, but to be fair, there has been a general quest to continually
improve the OS over the last 20 years that I've been using it.

Best regards,
Paarvai
