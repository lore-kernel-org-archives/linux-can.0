From: Paarvai Naai <opensource3141@gmail.com>
Subject: getifaddrs and SocketCAN interfaces
Date: Sat, 28 Mar 2015 13:30:21 -0700
Message-ID: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36824 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbC1UaW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 28 Mar 2015 16:30:22 -0400
Received: by obbld8 with SMTP id ld8so42420271obb.3
        for <linux-can@vger.kernel.org>; Sat, 28 Mar 2015 13:30:21 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I recently tried using getifaddrs to list all of the SocketCAN
interfaces on my system programmatically.

However, I found that the SocketCAN interfaces do not have their
ifa_addr field in the returned ifaddrs structure set.  This makes it
not possible to identifying the interface as type SocketCAN.
Presumably if the ifa_addr field was set, we could look at the
sa_family field and check if it is AF_CAN.

The other option is to use netlink to query the network devices, but
that is more involved.  Is there an easier way?

Thanks!
Paarvai
