From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: want blocking writes, but eventually get: errno 105 (No buffer
 space available)
Date: Mon, 27 Jun 2016 09:24:53 +1000
Message-ID: <57706445.80506@optusnet.com.au>
References: <loom.20160622T163626-806@post.gmane.org>
 <loom.20160622T171459-416@post.gmane.org>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:35089 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459AbcFZXor (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2016 19:44:47 -0400
In-Reply-To: <loom.20160622T171459-416@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org

On 23/06/16 01:18, ajneu wrote:
> ajneu <ajneu1 <at> gmail.com> writes:
>
>> My test-program blocks (in write) in the beginning (the 1st few
>> program-runs), but then after a number of program-restarts I eventually get:
>>     errno 105 (No buffer space available)
>> which is not acceptable, since I want to block (in the write), and not get
>> any error!!

Very old news. CAN is implemented "sort of like IP-over-Ethernet, and so has 
inherited the buffering from that system. So there's a NETBUF queue. When that 
one overflows you get ENOBUFS. So you can change it with:

     setsockopt(pSkt->skt, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));

Other details here:

http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html

Search for ENOBUFS in this as well:

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

 > 1st program run:
 > ~> block on 33'rd write (32 frames queued)

You'll have the Network queue, the "tx_queue_len" in the driver, as well as 
however many physical message buffers there are in your hardware, which looks 
to be "32".

Tom


