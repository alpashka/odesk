# encoding: utf-8

module Odesk
  # Class to represent jobs return in api calls
  class Job
    STRING_ATTRS = {
      assignment_info: 'assignment_info', #
      company_id: 'company_ref', # 1094536
      country: 'op_country', # United States
      description_digest: 'op_desc_digest', # Market for me on Craigslist
      description: 'op_description', # Market for me on Craigslist
      engagement: 'op_engagement', # Full-time - 30+ hrs/week
      id: 'op_recno', # 203119302
      job_category_seo: 'op_job_category_seo', # Sales / Lead Generation Jobs
      title: 'op_title' # Craigslist Marketer
    }

    attr_reader *STRING_ATTRS.keys

   #   amount: "amount", #10
   #   assignments: "assignments", #
   #   candidiates: "candidates", #
   #   active_candidates: "candidates_total_active", #0
   #   ciphertext: "ciphertext", #~012247edf127c1c0c5
   #   company_id: "company_ref", #1094536
   #   date_posted: "date_posted", #October 10, 2013
   #   engagement_related: "engagement_related", #
   #   engagement_weeks: "engagement_weeks", #
   #   hours_per_week: "hours_per_week", #40
   #   interviewees: "interviewees_total_active", #0
   #   job_category_level_one: "job_category_level_one", #Sales & Marketing
   #   job_category_level_two: "job_category_level_two", #Sales & Lead Generation
   #   job_type: "job_type", #Fixed
   #   offers_total: "offers_total", #0
   #   offers_total_open: "offers_total_open", #0
   #   active: "op_active", #0
   #   adjusted_score: "op_adjusted_score", #0
   #   attachment: "op_attached_doc", #
   #   avg_active_bid: "op_avg_bid_active", #0
   #   avg_active_interviewees_bid: "op_avg_bid_active_interviewees", #0
   #   avg_all_bid: "op_avg_bid_all", #0
   #   avg_interviewees_bid: "op_avg_bid_interviewees", #0
   #   avg_hourly_rate: "op_avg_hourly_rate_active", #0
   #   avg_active_interviewees_hourly_rate: "op_avg_hourly_rate_active_interviewees", #0
   #   avg_all_hourly_rate: "op_avg_hourly_rate_all", #0
   #   : "op_avg_hourly_rate_interviewees", #0
   #   : "op_candidate_type_pref", #0
   #   : "op_changed_date", #1381363200000
   #   : "op_city", #
   #   : "op_cny_description", #
   #   : "op_cny_show_in_profile", #
   #   : "op_cny_summary", #
   #   : "op_cny_suspended", #
   #   : "op_cny_upm_verified", #0
   #   : "op_cny_url", #
   #   : "op_comm_status", #Closed: Inappropriate Job Posting
   #   : "op_contract_date", #
   #   : "op_contractor_tier", #
   #   : "op_ctime", #1381423009000
   #   : "op_date_created", #October 10, 2013
   #   : "op_end_date", #October 10, 2013
   #   : "op_eng_type", #1
   #   : "op_est_duration", #
   #   : "op_high_bid_active", #0
   #   : "op_high_bid_active_interviewees", #0
   #   : "op_high_bid_all", #0
   #   : "op_high_bid_interviewees", #0
   #   : "op_high_hourly_rate_active", #0
   #   : "op_high_hourly_rate_active_interviewees", #0
   #   : "op_high_hourly_rate_all", #0
   #   : "op_high_hourly_rate_interviewees", #0
   #   : "op_hours_last30days", #0
   #   : "op_is_console_viewable", #1
   #   : "op_is_hidden", #
   #   : "op_is_searchable", #1
   #   : "op_is_validnonprivate", #1
   #   : "op_is_viewable", #0
   #   : "op_job_expiration", #
   #   : "op_last_buyer_activity", #January 1, 1970
   #   : "op_logo", #
   #   : "op_low_bid_active", #0
   #   : "op_low_bid_active_interviewees", #0
   #   : "op_low_bid_all", #0
   #   : "op_low_hourly_rate_active", #0
   #   : "op_low_hourly_rate_active_interviewees", #0
   #   : "op_low_hourly_rate_all", #0
   #   : "op_low_hourly_rate_interviewees", #0
   #   : "op_lowhigh_bid_interviewees", #0
   #   : "op_num_of_pending_invites", #0
   #   : "op_other_jobs", #
   #   : "op_pref_english_skill", #0
   #   : "op_pref_fb_score", #0
   #   : "op_pref_group_recno", #
   #   : "op_pref_has_portfolio", #0
   #   : "op_pref_hourly_rate_max", #
   #   : "op_pref_hourly_rate_min", #
   #   : "op_pref_hours_per_week", #
   #   : "op_pref_location", #
   #   : "op_pref_odesk_hours", #0
   #   : "op_pref_test", #0
   #   : "op_pref_test_name", #
   #   : "op_private_rating_active", #
   #   : "op_reason", #Inappropriate Job Posting
   #   : "op_reason_id", #116
   #   : "op_required_skills", #
   #   : "op_skill", #
   #   : "op_start_date", #October 10, 2013
   #   : "op_state", #
   #   : "op_time_created", #16:36:49
   #   : "op_time_posted", #16:36:49
   #   : "op_timezone", #UTC-05:00 Eastern Time (US & Canada)
   #   : "op_tot_asgs", #0
   #   : "op_tot_cand", #0
   #   : "op_tot_cand_client", #0
   #   : "op_tot_cand_prof", #0
   #   : "op_tot_charge", #0
   #   : "op_tot_feedback", #0
   #   : "op_tot_fp_asgs", #0
   #   : "op_tot_hours", #0
   #   : "op_tot_hr_asgs", #0
   #   : "op_tot_jobs_filled", #0
   #   : "op_tot_jobs_open", #0
   #   : "op_tot_jobs_posted", #0
   #   : "op_tot_new_cond", #0
   #   : "op_tot_rej", #0
   #   : "op_ui_profile_access", #Public
   #   : "search_status", #Cancelled
   #   : "timezone", #United States (UTC-05)
   #   : "tot_act_asgs", #0
   #   : "ui_job_profile_access", #public
   #   : "ui_opening_status", #Closed
   #   : "version" #1
   #   }
   # end

    def initialize(json)
      STRING_ATTRS.each do |attr, key|
        instance_variable_set("@#{attr}", json[key])
      end
    end
  end
end
