From: Luis de Arquer <ldearquer@gmail.com>
Subject: Re: Kvaser lapcan driver (init and probe)
Date: Sun, 22 Jun 2014 17:29:25 +0100
Message-ID: <1403454565.3506.3.camel@PCLUK>
References: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
	 <53A5990A.5050409@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53053 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbaFVQ3c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Jun 2014 12:29:32 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so2910520wib.3
        for <linux-can@vger.kernel.org>; Sun, 22 Jun 2014 09:29:31 -0700 (PDT)
In-Reply-To: <53A5990A.5050409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hello Oliver,

Thanks for your help.

> 
> So you should post your driver on either linux-pcmcia@lists.infradead.org
> and linux-can@vger.kernel.org.
> 

Yes, I'll do. I had only checked the vger lists, that's why I didn't
find the pcmcia one :(

I will submit it as a patch then -it is a bit of an empty driver, doing
only low level initialization and no CAN stuff yet, I hope it is
alright.

Regards,
Luis


