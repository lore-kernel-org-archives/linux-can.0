From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 0/2] iproute2: can: support CAN FD control interface
Date: Fri, 9 May 2014 12:12:08 -0700
Message-ID: <20140509121208.33676194@nehalam.linuxnetplumber.net>
References: <1398274047-5407-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1398274047-5407-1-git-send-email-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Wed, 23 Apr 2014 19:27:25 +0200
Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> For CAN FD a new set of bittiming configuration and enabling functions for the
> data section is provided by the CAN driver infrastructure.
> 
> This patch set allows to configure the newly introduced CAN FD properties.
> 
> Tested with PEAK PCAN USB pro FD pilot series hardware.
> 
> Oliver Hartkopp (2):
>   iproute2: can: fix indention white spaces
>   iproute2: can: support CAN FD control interface
> 
>  ip/iplink_can.c | 144 +++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 107 insertions(+), 37 deletions(-)
> 

Accepted
