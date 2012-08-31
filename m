From: Andrew Bell <andrew.bell.ia@gmail.com>
Subject: Full Buffers and the Passive bus
Date: Fri, 31 Aug 2012 11:36:17 -0500
Message-ID: <CACJ51z3wGmSnZ3U-qe_QLSPnNuRb54k5=5zuQ+DBQ0aFohcvVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38739 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab2HaQgS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 12:36:18 -0400
Received: by obbuo13 with SMTP id uo13so5856125obb.19
        for <linux-can@vger.kernel.org>; Fri, 31 Aug 2012 09:36:17 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Is there some way within socket CAN to detect the state when no nodes
are on the BUS?  I do get CAN_ERR_TX_TIMEOUT error frames after some
time, but I'm writing to the BUS faster than frames drain from the
buffers, so eventually buffers fill up and writes start failing.  In
this case, write does return ENOBUFS.  But I'd like to be able to
differentiate between the case where buffers are full because of some
transient condition (I'm writing too fast for the BUS) and the
condition when nobody is home to receive anything at all.

Suggestions appreciated.

--
Andrew Bell
andrew.bell.ia@gmail.com
