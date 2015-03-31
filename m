From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Tue, 31 Mar 2015 14:09:39 +1100
Message-ID: <551A0FF3.4070400@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au> <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59809 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753318AbbCaDJn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Mar 2015 23:09:43 -0400
In-Reply-To: <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>
Cc: linux-can@vger.kernel.org

On 31/03/15 11:26, Paarvai Naai wrote:
> Hi Tom,
 > ...
> If there are multiple clients, there is idneed the priority inversion
> problem you mention.  Even if one has a single process designated to
> read/write to the interface, managing priority is not fool proof.  A
> low priority message could get submitted to the underlying SocketCAN
> interface and be unable to go out onto the bus because of other
> third-party nodes on the bus sending higher priority traffic at high
> frequency.  This would block further messages from going out on the
> SocketCAN interfaces, even though they have higher priority, no?

Of course. That's the working definition of "PRIORITY".

If that happens the system is behaving exactly as it has been designed to do, 
both by the hardware and software vendors, and by YOU, the default "System 
Architect".

It that isn't doing what you want it to do, reassign the IDs so the "Higher 
Priority" or time sensitive messages have a higher priority, and the "high 
frequency" traffic has a sensibly lower priority.

CAN was never meant to be used in an "Open System" where different and 
unrelated devices can be plugged onto a common bus. It is meant to be used n a 
single car where the whole system has been designed, specified (including 
assignment of all IDs with appropriate priorities), and rigorously tested to 
ensure the situation you're describing can't happen.

Tom

