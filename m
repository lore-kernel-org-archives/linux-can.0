From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socketcan and perl module ?
Date: Tue, 11 Dec 2012 17:46:25 +0100
Message-ID: <50C76361.7000605@hartkopp.net>
References: <eb163bb46a69fe58c0d3f9676172ed9a@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p04-ob.rzone.de ([81.169.146.178]:53693 "EHLO
	mo-p04-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2LKQqc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 11:46:32 -0500
In-Reply-To: <eb163bb46a69fe58c0d3f9676172ed9a@localhost>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rastislav Piater <rass@rassnet.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Rastislav,

i've been on your website 2-3 years ago - it has been really improved

I don't have any knowledge about perl. But there was an attempt to support
SocketCAN network sockets in perl in 2010 (just google 'socketcan perl').

If this attempt does not help, you may be interested in kayak, which includes
a 'socketcand' for remote CAN access via network (also on localhost):

http://kayak.2codeornot2code.org/tutorial.html

Btw. don't hesitate to ask these kind of questions on the mailing list:

"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I've put the ML on CC.

Best regards,
Oliver

On 11.12.2012 16:32, Rastislav Piater wrote:

> Hello,
> 
>  
> 
> Socket can is really great project.
> 
> I created  open source saab player based on socket-can. (http://saablin.net/)
> 
> Issue is that I developed it in perl, and for sending and receiving can
> messages, I am calling candump and cansend binary from perl which is not so
> good (effective).
> 
> What do you think to create perl module for candump and cansend ?
> 
> This will help me and maybe more peoples to develop applications with socket can.
> 
>  
> 
> I am not real developer, so I don't have knowledge to port  candump and
> cansend to perl ... can bus  it's just my hobby.
> 
>  
> 
> Thank you for  your answer.
> 
> Rastislav
> 
>  
> 
>  
> 
>  
> 
>  
> 
>  
> 


