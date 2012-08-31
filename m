From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Full Buffers and the Passive bus
Date: Fri, 31 Aug 2012 18:49:02 +0200
Message-ID: <5040EAFE.9000500@hartkopp.net>
References: <CACJ51z3wGmSnZ3U-qe_QLSPnNuRb54k5=5zuQ+DBQ0aFohcvVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:13207 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab2HaQtF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 12:49:05 -0400
In-Reply-To: <CACJ51z3wGmSnZ3U-qe_QLSPnNuRb54k5=5zuQ+DBQ0aFohcvVw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: linux-can@vger.kernel.org

On 31.08.2012 18:36, Andrew Bell wrote:

> Is there some way within socket CAN to detect the state when no nodes
> are on the BUS?  I do get CAN_ERR_TX_TIMEOUT error frames after some
> time, but I'm writing to the BUS faster than frames drain from the
> buffers, so eventually buffers fill up and writes start failing.  In
> this case, write does return ENOBUFS.  But I'd like to be able to
> differentiate between the case where buffers are full because of some
> transient condition (I'm writing too fast for the BUS) and the
> condition when nobody is home to receive anything at all.
> 
> Suggestions appreciated.


Hello Andrew,

this first idea was to check, if the successful transmissions increase the tx
counter in the netdevice statistics. When there's no increasing value no
frames have been sent on the wire.

But maybe there's another suggestion out there ...

Regards,
Oliver

