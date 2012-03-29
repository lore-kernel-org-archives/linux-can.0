From: Luka Rahne <luka.rahne@gmail.com>
Subject: nonblocking socketcan
Date: Thu, 29 Mar 2012 15:26:02 +0200
Message-ID: <CAOHwv553C_wH3TkoGDdF2ibPsXArOpB+6eoeg41TJH7oXcjc7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59947 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903Ab2C2N0E (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Mar 2012 09:26:04 -0400
Received: by lahj13 with SMTP id j13so2445255lah.19
        for <linux-can@vger.kernel.org>; Thu, 29 Mar 2012 06:26:02 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I do not know if this is correct address, but I have been playing whit
socketcan using python. (Python 3.3.0a1+)

I was able to set socket as non-blocking but I got io.BlockingIOError
if there is no data after calling receive.

Putting it in try - except(io.BlockingIOError): works just fine

full working source is here http://pastebin.com/TBX85TrN

I am just asking  if this is normal behaviour, bug or misconfiguration?
