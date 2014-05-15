From: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Subject: J1939 support issiues
Date: Thu, 15 May 2014 16:00:22 -0400
Message-ID: <CAJdBzeAkxtQKTcr863OJiLJkXyOOxTn-eEEUbCirA7gbQ95kYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:57993 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbaEOUAX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 May 2014 16:00:23 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so8391975igb.12
        for <linux-can@vger.kernel.org>; Thu, 15 May 2014 13:00:23 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm trying to get J1939 support for an Ubuntu machine, and I'm running
into some issues.

When I try to compile the can-j1939-utils (against ubuntu-lts-3.8
kernel) I am getting an error.

"libj1939.h:3:29 fatal error: linux/can/j1939.h: No such file or directory"

I can see the file in the the linux-can-j1939 repo, but not in my
merged source, or in /usr/include on the target machine. Any idea
what's going wrong?
