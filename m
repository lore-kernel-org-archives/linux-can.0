From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: BCM loopback - Information request
Date: Tue, 20 Sep 2016 11:53:33 +0200
Message-ID: <1509366.LC0YPQ3zn0@ws-stein>
References: <BECC71D675C45C4F912901A0BBE9A3A41493CD7D@srv-mail.DominioAlfa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59414 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932717AbcITJxo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2016 05:53:44 -0400
In-Reply-To: <BECC71D675C45C4F912901A0BBE9A3A41493CD7D@srv-mail.DominioAlfa.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Andrea,

On Tuesday 20 September 2016 09:42:53, Angeloni Andrea wrote:
> In my application there is a thread for each initialized CAN interface that
> sends over TCP all the read data to a Windows Client. Data are read using
> Socket RAW. Application is also capable to send cyclic messages using
> Broadcast manager.
> 
> Here is my question: how can I configure my application so that reading
> thread does not get messages sent by BCM on the same interface?

I think the socket option CAN_RAW_LOOPBACK is what you need. Please refer to 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/can.txt#n536
You will not receive CAN frames sent from interface (BCM and other CAN 
frames), thus only messages from other CAN nodes.

HTH
Alexander

