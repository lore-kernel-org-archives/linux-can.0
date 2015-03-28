From: Paarvai Naai <opensource3141@gmail.com>
Subject: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Sat, 28 Mar 2015 13:26:52 -0700
Message-ID: <CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34295 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbC1U0x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 28 Mar 2015 16:26:53 -0400
Received: by oigz129 with SMTP id z129so55905891oig.1
        for <linux-can@vger.kernel.org>; Sat, 28 Mar 2015 13:26:52 -0700 (PDT)
In-Reply-To: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I have been looking into how to query the SocketCAN interface for its
current tx_queue usage.  I found the following posts touching on this:
http://comments.gmane.org/gmane.network.socketcan.user/1255
http://socket-can.996257.n3.nabble.com/queuesize-manipulation-td310.html

It appears that there is no easy way to find out how much of the
interface's tx_queue has been filled up, but these posts are
relatively old.  Has there been any improved features in this regard
with SocketCAN?

Also, the tx_queue appears to be shared between clients of the
SocketCAN interface.  Even if one process checked the fill state of
the tx_queue, another process could consume the remaining space in the
tx_queue before the first process submits its message for
transmission.  This means that clients have to implement their own TX
queues and use poll() (either in a thread or in the application's main
loop) to occasionally service their private TX queues when the
SocketCAN interface is able to accept new messages.

I saw the following article about using qdisc with SocketCAN but
haven't looked at it in detail yet:
http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
Has anyone else used qdisc to get around the problem I mention?

Thanks in advance!
Paarvai
