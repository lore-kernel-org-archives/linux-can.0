From: =?UTF-8?Q?Micka=c3=abl_Gu=c3=a9rin?= <kael@crocobox.org>
Subject: Re: using VCAN interfaces with containers
Date: Mon, 17 Oct 2016 13:19:37 +0200
Message-ID: <7ba72b31-20fa-6c95-54c3-391fe1dd3048@crocobox.org>
References: <e2bccb97-c0b8-617b-a6e3-b273a05f48e8@crocobox.org>
 <147670126999.12954.15947433823240101893@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cookie.crocobox.org ([5.135.166.110]:51826 "EHLO
        cookie.crocobox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935077AbcJQLTl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Oct 2016 07:19:41 -0400
In-Reply-To: <147670126999.12954.15947433823240101893@maxwell>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org

Le 17/10/2016 à 12:47, Andri Yngvason a écrit :
> Network namespaces are not implemented for SocketCAN. I actually tried adding
> them a year ago [1], but I ran into trouble on multi-core systems. You are free
> to pick up where I left off.;)
I've seen your work but I thought it had been integrated; I admit I have 
not tryed anything yet ;)

> I found other means by which to achieve my goals, so I gave up on adding the
> namespaces. I created an abstraction that allowed me to forward CAN frames over
> TCP [2]. This method has the downside the you need to embed it into your code,
> but it's easier to do this that to implement net namespaces for CAN.
Same conclusion for me too. It seems to be the easy way.

thanks,

-- 
Mickaël.

