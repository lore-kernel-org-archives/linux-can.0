From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Dropped Tx frames with SJA1000
Date: Wed, 27 Jul 2016 17:17:27 +1000
Message-ID: <111f48cb-d8e6-67fc-9644-389f342601cb@optusnet.com.au>
References: <CABeNA8droHfwjaTkqnjbJBZTmETy_n58QDxFq9dne9w1EcjyHQ@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41244 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581AbcG0HRb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2016 03:17:31 -0400
In-Reply-To: <CABeNA8droHfwjaTkqnjbJBZTmETy_n58QDxFq9dne9w1EcjyHQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Damien Dusha <d.dusha@gmail.com>, linux-can@vger.kernel.org

On 27/07/16 16:23, Damien Dusha wrote:
> Dear linux-can,
>
> I am attempting to debug an issue with the SJA1000 driver. The symptom
> is the occasional dropped frame when transmitting a burst of frames.
> Reception is unaffected.

I've sent a detailed response in email. A summary:

"Pattern matching" this problem (not reading all of it, and doing exactly what 
we hate when we see "help desk" people do this) I'll ask:

* What are you setting "/sys/class/net/can0/tx_queue_len" to?

* Are your tools (cangen et al) making a "setsockopt(s, SOL_SOCKET, SO_SNDBUF, 
&buflen)" call with a sensible value? What do they do when they get ENOBUFS?

http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html

http://www.arm.com/files/pdf/cachecoherencywhitepaper_6june2011.pdf

Tom

