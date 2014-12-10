From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] iproute2: Add support for CAN presume-ack feature
Date: Tue, 9 Dec 2014 20:35:19 -0800
Message-ID: <20141209203519.7f0ff71c@urahara>
References: <1417766390-4587-1-git-send-email-nebaruzdin@gmail.com>
	<1417768902-5404-1-git-send-email-nebaruzdin@gmail.com>
	<1417768902-5404-2-git-send-email-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60045 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbaLJEfa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Dec 2014 23:35:30 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so1972188pac.25
        for <linux-can@vger.kernel.org>; Tue, 09 Dec 2014 20:35:29 -0800 (PST)
In-Reply-To: <1417768902-5404-2-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org

On Fri,  5 Dec 2014 11:41:42 +0300
Nikita Edward Baruzdin <nebaruzdin@gmail.com> wrote:

> This patch makes CAN_CTRLMODE_PRESUME_ACK netlink feature configurable.
> When enabled, the feature sets CAN controller in mode in which
> acknowledgement absence is ignored.
> 
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
> ---

Applied.
