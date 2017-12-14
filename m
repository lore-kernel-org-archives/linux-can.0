From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] ip: add vxcan to help text
Date: Wed, 13 Dec 2017 18:20:26 -0800
Message-ID: <20171213182026.080b503d@xeon-e3>
References: <20171213202128.4424-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171213202128.4424-1-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Wed, 13 Dec 2017 21:21:28 +0100
Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> Add missing tag 'vxcan' inside the help text which was missing in commit
> efe459c76d35f ('ip: link add vxcan support').
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied. Could you also fix the man page?
