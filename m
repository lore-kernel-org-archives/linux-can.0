From: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>
Subject: BCM loopback - Information request
Date: Tue, 20 Sep 2016 09:42:53 +0000
Message-ID: <BECC71D675C45C4F912901A0BBE9A3A41493CD7D@srv-mail.DominioAlfa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.efuture.it ([81.29.204.82]:36719 "EHLO relay.efuture.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbcITJnD (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Sep 2016 05:43:03 -0400
Received: from mail.alfamationglobal.com ([88.149.174.26])
        (authenticated user smarthost@efuture.it)
        by relay.efuture.it (Kerio Connect 9.1.1) with ESMTPSA
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256 bits))
        for linux-can@vger.kernel.org;
        Tue, 20 Sep 2016 11:42:53 +0200
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Good morning,

my name is Andrea Angeloni, I'm working for an Italian company manufacturing test benches for several industries.
At the moment I'm developing a C application on ARM Linux to communicate with DUT over CAN. I'm using SocketCAN APIs.

In my application there is a thread for each initialized CAN interface that sends over TCP all the read data to a Windows Client. Data are read using Socket RAW.
Application is also capable to send cyclic messages using Broadcast manager.

Here is my question: how can I configure my application so that reading thread does not get messages sent by BCM on the same interface?

Filtering by ID is not a viable solution because a priori I'm not able to know whether or not someone on the network will send data over the same IDs of BCM.

Thanks for a feedback, regards.
Andrea Angeloni

