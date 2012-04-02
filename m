From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: nonblocking socketcan
Date: Mon, 2 Apr 2012 13:52:02 +0200
Message-ID: <20120402115202.GB426@vandijck-laurijssen.be>
References: <CAOHwv553C_wH3TkoGDdF2ibPsXArOpB+6eoeg41TJH7oXcjc7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:44576 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751145Ab2DBLwE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Apr 2012 07:52:04 -0400
Content-Disposition: inline
In-Reply-To: <CAOHwv553C_wH3TkoGDdF2ibPsXArOpB+6eoeg41TJH7oXcjc7Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luka Rahne <luka.rahne@gmail.com>
Cc: linux-can@vger.kernel.org

Hi,

I'm no python user. My answer is therefore a bit abstract.

On Thu, Mar 29, 2012 at 03:26:02PM +0200, Luka Rahne wrote:
> I was able to set socket as non-blocking but I got io.BlockingIOError
> if there is no data after calling receive.
It is normal behaviour that when you attempt to receive from a nonblocking
socket (or any file descriptor), and no data is ready, you will "not block",
but return. Since the kernel cannot return you anything, it returns an
error (EWOULDBLOCK) to indicate that, well, just that you need to wait
a little more.

How exactly such kernel error is translated into python is a python
specific question, not purely related to socketCAN.
However, io.BlockingIOError is a perfect candidate, since, if you were
really blocking, there would be no way to hand over such error. As such,
I may assume this is the EWOULDBLOCK equivalent.
> 
[...]
> 
> I am just asking  if this is normal behaviour, bug or misconfiguration?
I strongly believe it's normal for asynchronous systems like CAN.

Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
