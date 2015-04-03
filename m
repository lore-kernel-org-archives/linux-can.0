From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Fri, 03 Apr 2015 12:08:46 +0100
Message-ID: <1f3de4fb-6a20-48aa-9b6b-102ef079e299@email.android.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com> <CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com> <55187FF1.7020701@optusnet.com.au> <CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com> <5519E5A9.7080104@optusnet.com.au> <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com> <551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CE5C9.6020600@pengutronix.de> <CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com> <551DEE7C.6040202@optusnet.com.au> <CAE+ymrv6PeLU9EbJcC8mfwQSXQyGjMVG6fSkY-NZAUmCW+U2tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48966 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbDCLKd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2015 07:10:33 -0400
In-Reply-To: <CAE+ymrv6PeLU9EbJcC8mfwQSXQyGjMVG6fSkY-NZAUmCW+U2tw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>, Tom Evans <tom_usenet@optusnet.com.au>
Cc: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

On April 3, 2015 7:45:46 AM GMT+01:00, Paarvai Naai <opensource3141@gmail.com> wrote:
>Hi Tom,
>
>> Didn't I already answer that question a few days ago?
>
>Yes, somewhat, but I was hoping for something more concrete from Marc
>(or someone else), which is why I posed the question again.  (Also,
>I'm not a huge fan of programmatically interfacing with the
>system-level control/status via the /sys filesystem....)

As this is not CAN specific, you might want to ask over on the netdev mailing list (please add linux-can on Cc). Maybe there's a socket option or ioctl for this, if not maybe you can rise the awareness for this need and get hints how to implement and mainline this.

Marc
