From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Fri, 03 Apr 2015 21:28:47 +0100
Message-ID: <7573caff-e3ce-4927-a12b-11d98b8cb333@email.android.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com> <CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com> <55187FF1.7020701@optusnet.com.au> <CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com> <5519E5A9.7080104@optusnet.com.au> <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com> <551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CE5C9.6020600@pengutronix.de> <CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com> <551DEE7C.6040202@optusnet.com.au> <CAE+ymrv6PeLU9EbJcC8mfwQSXQyGjMVG6fSkY-NZAUmCW+U2tw@mail.gmail.com> <1f3de4fb-6a20-48aa-9b6b-102ef079e299@email.android.com>
  <CAE+ymrtAR7ENaptVsaoZe=ADHy_D=4kLe-Dw-GX1rNzncg4eqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40522 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbDCUeD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2015 16:34:03 -0400
In-Reply-To: <CAE+ymrtAR7ENaptVsaoZe=ADHy_D=4kLe-Dw-GX1rNzncg4eqQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org



On April 3, 2015 4:24:57 PM GMT+01:00, Paarvai Naai <opensource3141@gmail.com> wrote:
>(reposting to linux-can as it seems my email client somehow forgot
>this thread should have remained plain text)
>
>Hi Marc,
>
>Thanks for the suggestions.  Happy to cross-post to netdev, but just
>one more question before I do so to make sure I am most effective when
>dialoguing with those folks.  I was under the impression that the way
>one sets up the tx_queue_len is by doing:
>
>ip link set can type can tx_queue_len 32
>
>or equivalently through Netlink with a CAN-specific option (see
>libsocketcan).  This suggests that tx_queue_len option is
>CAN-specific.  Or does setting tx_queue_len simply pass the
>configuration on to the qdisc layer of the kernel?

Just glancing at libsocketcan, I don't see an option to set the tx queue len. The parameter is not CAN specific. 

Marc
