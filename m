From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Fri, 4 Jan 2019 10:28:35 +0100
Message-ID: <734c27f9-f39e-3cbc-6cc3-2c805fed4922@hartkopp.net>
References: <20190103122634.2530-1-socketcan@hartkopp.net>
 <20190103140121.GB28932@unicorn.suse.cz>
 <9e4dfe7c-42cc-3dba-763a-23ce4e10389b@hartkopp.net>
 <20190103203347.GC28932@unicorn.suse.cz>
 <715d1d82-af65-9344-dcce-0ddcace50274@hartkopp.net>
 <20190104090143.GD28932@unicorn.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190104090143.GD28932@unicorn.suse.cz>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Michal Kubecek <mkubecek@suse.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Michal,

On 1/4/19 10:01 AM, Michal Kubecek wrote:
> On Thu, Jan 03, 2019 at 10:03:47PM +0100, Oliver Hartkopp wrote:
>> 1. I'm still using the test "if (cf->can_dlc > 8)" with a proper comment as
>> CAN_MAX_DLC and CAN_MAX_DLEN are not defined in Linux stable 3.2 - so that
>> we can apply the patch to all versions of gw.c
> 
> I may be biased as substantial part of my work consists of trying to
> understand unfamiliar code written by other people but I believe
> readability of the code is more important than avoiding a bit of work
> with backport to older stable branches.

I am with you.
Please take a look into the new patch. I think either the comment and 
the commit message make it very clear where the value comes from.

E.g. in cgw_chk_csum_parms() we have tons of fixed constants that have 
been introduced when CAN FD was far away from thinking. I introduced 
CAN_MAX_DLC and CAN_MAX_DLEN myself when I started the CAN FD support in 
Linux. gw.c would need a rework for full CAN FD support - where these 
defines then definitely would be introduced.

In this single case the simple applying to stable kernels weighted more 
to me.

Regards,
Oliver
