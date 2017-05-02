From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Solved !. Can-utils and mininet :
Date: Tue, 2 May 2017 13:26:10 +0200
Message-ID: <f22d3e31-1a36-1288-14fd-64a6147aab7c@hartkopp.net>
References: <BL2PR09MB1107D1C78001B6BCCAF7F99DE1170@BL2PR09MB1107.namprd09.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:21553 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdEBL02 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 May 2017 07:26:28 -0400
In-Reply-To: <BL2PR09MB1107D1C78001B6BCCAF7F99DE1170@BL2PR09MB1107.namprd09.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Halba, Khalid (IntlAssoc)" <khalid.halba@nist.gov>
Cc: Mario Kicherer <dev@kicherer.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Mahmoudi, Charif (IntlAssoc)" <charif.mahmoudi@nist.gov>

Hi Khalid,

thanks for your success report!

On 05/02/2017 02:59 AM, Halba, Khalid (IntlAssoc) wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/snapshot/net-next-4.11-rc8.tar.gz
>
>  but it seems like it lacks peak_canfd directory, which caused the build to fail  ( see attached file Capture.JPG):

I tried 'make mrproper' in the latest net-next tree from Dave Miller 
without problems.

> I didn't need the tunnel configuration since my purpose was to run can-utils within mininet nodes. So I didn't use the commands below at all:
>
> # ./ip link add rootcan type vxcan peer name bluecan # ./ip link set dev bluecan netns blue

Ok.

> I tried mininet with cangen and candump within same node and it worked ! (check 1_node_test.JPG)
>
> Also I used a program that I developed myself to wrap CAN messages in IPV4 packets using a client-server sockets model , and I was able to send can traffic from node h1 to node h2 within mininet.
>
> This issue is solved. We can now use mininet to simulate CAN traffic between multiple nodes.

Great! Thanks for testing!

If you see any problems or questions with the namespace support please 
let us now.

Have fun,
Oliver
