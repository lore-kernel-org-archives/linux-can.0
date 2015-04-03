From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Fri, 3 Apr 2015 13:53:17 -0700
Message-ID: <CAE+ymrv612owtryP_hissydhip-eSzmytxKn6uirfOczJOK0Fw@mail.gmail.com>
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
	<551CE5C9.6020600@pengutronix.de>
	<CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com>
	<551DEE7C.6040202@optusnet.com.au>
	<CAE+ymrv6PeLU9EbJcC8mfwQSXQyGjMVG6fSkY-NZAUmCW+U2tw@mail.gmail.com>
	<1f3de4fb-6a20-48aa-9b6b-102ef079e299@email.android.com>
	<CAE+ymrtAR7ENaptVsaoZe=ADHy_D=4kLe-Dw-GX1rNzncg4eqQ@mail.gmail.com>
	<7573caff-e3ce-4927-a12b-11d98b8cb333@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34851 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbbDCUxS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2015 16:53:18 -0400
Received: by obbfy7 with SMTP id fy7so99356177obb.2
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2015 13:53:17 -0700 (PDT)
In-Reply-To: <7573caff-e3ce-4927-a12b-11d98b8cb333@email.android.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

Hi Marc,

> Just glancing at libsocketcan, I don't see an option to set the tx queue len. The parameter is not CAN specific.

You are right, of course.  My confusion stemmed from the fact that
someone else here pulled down libsocketcan and then modified it to add
this as an API call to libsocketcan.{h,cc}.  Thanks for setting me
straight.  I will look into this further.

Paarvai
