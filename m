From: Rastislav Piater <rass@rassnet.org>
Subject: Re: socketcan and perl module =?UTF-8?Q?=3F?=
Date: Wed, 12 Dec 2012 13:13:07 +0100
Message-ID: <94265ad687b0bd3c02c7efeceeb0e5b6@localhost>
References: <eb163bb46a69fe58c0d3f9676172ed9a@localhost> <50C76361.7000605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 772662-everela.ba.psg.sk ([195.28.75.178]:45570 "EHLO
	mail.wishion.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2LLMWT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Dec 2012 07:22:19 -0500
In-Reply-To: <50C76361.7000605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hello Oliver, 

thanks for fast answer.
Yes, you are right, there was an attempt to implement socketcan to perl:

http://www.nntp.perl.org/group/perl.modules/2010/08/msg72366.html

It was by my request to my fiend,  I  pushed him to create module for me
:-)
Hi post it in 2010, but still not finished, I must push him again to
finish it. 

I also check your recommendation for socketcand, and it looks really good.
For tcp/ip have existing module in perl, so it seems I can do it via
socketcand.

So I will try socketcand way ...  and I will see. 

Thanks,
Rastislav  





On Tue, 11 Dec 2012 17:46:25 +0100, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
> Hello Rastislav,
> 
> i've been on your website 2-3 years ago - it has been really improved
> 
> I don't have any knowledge about perl. But there was an attempt to
support
> SocketCAN network sockets in perl in 2010 (just google 'socketcan
perl').
> 
> If this attempt does not help, you may be interested in kayak, which
> includes
> a 'socketcand' for remote CAN access via network (also on localhost):
> 
> http://kayak.2codeornot2code.org/tutorial.html
> 
> Btw. don't hesitate to ask these kind of questions on the mailing list:
> 
> "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> 
> I've put the ML on CC.
> 
> Best regards,
> Oliver
> 
> On 11.12.2012 16:32, Rastislav Piater wrote:
> 
>> Hello,
>> 
>>  
>> 
>> Socket can is really great project.
>> 
>> I created  open source saab player based on socket-can.
>> (http://saablin.net/)
>> 
>> Issue is that I developed it in perl, and for sending and receiving can
>> messages, I am calling candump and cansend binary from perl which is
not
>> so
>> good (effective).
>> 
>> What do you think to create perl module for candump and cansend ?
>> 
>> This will help me and maybe more peoples to develop applications with
>> socket can.
>> 
>>  
>> 
>> I am not real developer, so I don't have knowledge to port  candump and
>> cansend to perl ... can bus  it's just my hobby.
>> 
>>  
>> 
>> Thank you for  your answer.
>> 
>> Rastislav
>> 
>>  
>> 
>>  
>> 
>>  
>> 
>>  
>> 
>>  
>>
