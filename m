From: Luis de Arquer <ldearquer@gmail.com>
Subject: Re: Kvaser lapcan driver (init and probe)
Date: Sun, 22 Jun 2014 17:38:42 +0100
Message-ID: <1403455122.3506.12.camel@PCLUK>
References: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
	 <20140621212823.GA28234@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:48870 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaFVQip (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Jun 2014 12:38:45 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so5612698wes.8
        for <linux-can@vger.kernel.org>; Sun, 22 Jun 2014 09:38:44 -0700 (PDT)
In-Reply-To: <20140621212823.GA28234@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

Hi Kurt,

Thanks for revising.

> 
> Did you try to use request_resource, and ommitting pcmcia_request_io.
> 

It may be ok to use request_resource, but I am not too sure about
it. That sounds to me a bit like bypassing the pcmcia socket module,
which knows the actual range of I/O ports that can be requested -all I
really know is that I need 3 I/O lines. 


> The IRQ should only be fired when the CAN chip is running, which is way later.
> You did well.
> 

Thanks, that's reassuring :)

Luis

